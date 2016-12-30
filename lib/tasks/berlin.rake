namespace :bm do
  AGENT_STR = 'Ruby RDF Benchmark (https://rubygems.org/gems/rdf-benchmark)'
  BSBM_URI  = 'http://downloads.sourceforge.net/project/' \
              'bsbmtools/bsbmtools/bsbmtools-0.2/bsbmtools-v0.2.zip'.freeze
  TMPDIR    = 'tmp'
  FILENAME  = File.join(TMPDIR, BSBM_URI.split('/').last)

  namespace :berlin do
    desc 'download berlin tools'
    task 'download' do
      exit if File.exists? FILENAME
      FileUtils.mkdir(TMPDIR) unless File.exists?(TMPDIR)

      require 'net/http'
      require 'logger'

      logger = Logger.new(STDOUT)

      def request(uri, limit: 3, logger: nil, agent: AGENT_STR)
        if limit < 1
          msg = 'Too many redirects!'
          logger.error msg
          raise msg
        end

        uri = URI(uri)
        req = Net::HTTP::Get.new(uri.path, { 'User-Agent' => agent })

        logger.info "GET #{uri}" if logger
        
        response = Net::HTTP.start(uri.host, uri.port) do |http|
          http.request(req)
        end

        case response
        when Net::HTTPSuccess     then response
        when Net::HTTPRedirection then request(response['location'], 
                                               limit:  limit - 1,
                                               logger: logger)
        else
          response.error!
        end
      end

      logger.info "Downloading to #{FILENAME}"

      open(FILENAME, 'w') do |io|
        request(BSBM_URI, logger: logger).read_body do |chunk| 
          io.write(chunk)
        end
      end
    end
  end
end

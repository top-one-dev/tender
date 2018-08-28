if Rails.env.production?

  PDFKit.configure do |config|
    config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
  end

end
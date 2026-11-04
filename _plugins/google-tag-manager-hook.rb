# frozen_string_literal: true

# Injects Google Tag Manager without overriding Chirpy's theme layouts.
# The existing direct GA4 tag remains enabled until the GTM GA4 tag is
# configured and verified, preventing a gap in analytics collection.
Jekyll::Hooks.register %i[pages documents], :post_render do |document|
  site = document.site
  container_id = site.config.dig("google_tag_manager", "id")

  next unless container_id&.match?(/\AGTM-[A-Z0-9]+\z/)
  next unless document.output_ext == ".html"
  next unless document.output.include?("</head>")
  next if document.output.include?("<!-- Google Tag Manager -->")

  head = <<~HTML
    <!-- Google Tag Manager -->
    <script>
      (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
      new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
      j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
      'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
      })(window,document,'script','dataLayer','#{container_id}');
    </script>
    <!-- End Google Tag Manager -->
  HTML

  body = <<~HTML
    <!-- Google Tag Manager (noscript) -->
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=#{container_id}"
    height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <!-- End Google Tag Manager (noscript) -->
  HTML

  document.output.sub!("</head>", "#{head}</head>")
  document.output.sub!(/<body([^>]*)>/, "<body\\1>#{body}")
end

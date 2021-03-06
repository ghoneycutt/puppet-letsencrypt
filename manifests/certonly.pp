define letsencrypt::certonly (
  Array[String]                           $domains          = [$title],
  Enum['apache', 'standalone', 'webroot'] $plugin           = 'standalone',
  String                                  $letsencrypt_path = $letsencrypt::path,
) {

  $command = inline_template('<%= @letsencrypt_path %>/letsencrypt-auto certonly --<%= @plugin %> -d <%= @domains.join(" -d ")%>')
  $live_path = inline_template('/etc/letsencrypt/live/<%= @domains.first %>/cert.pem')

  exec { "letsencrypt certonly ${title}":
    command => $command,
    path    => $::path,
    creates => $live_path,
    require => Class['letsencrypt']
  }
}

class cutover::environment (
  $puppet_conf,
  $environment,
  $environment_section,
) {
  cutover::private_warning { 'cutover::environment': }
  validate_string($puppet_conf)
  validate_absolute_path($puppet_conf)
  validate_string($environment)
  validate_string($environment_section)

  ini_setting { 'environment':
    ensure  => present,
    path    => $puppet_conf,
    section => $environment_section,
    setting => 'environment',
    value   => $environment,
  }
}

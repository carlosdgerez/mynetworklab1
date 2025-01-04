# frozen_string_literal: true

Facter.add('mysql_version') do
  confine { Facter::Core::Execution.which('mysql') }
  setcode do
    mysql_ver = Facter::Core::Execution.execute('mysql --version')
    if mysql_ver
      match = mysql_ver.match(%r{\d+\.\d+\.\d+})
      match ? match[0] : 'unknown'
    else
      'unknown'
    end
  end
end

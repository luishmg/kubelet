# frozen_string_literal: true

# Molecule managed

describe file('/etc/hosts') do
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0644' }
end

conf_list = %w(
  /opt/templates/kubelet-config.yaml.j2
  /opt/templates/kubelet.service.j2
  /etc/sysctl.conf
  /opt/bootstrap-scripts/bootstrap-kubelet.sh
  /opt/bootstrap-scripts/generate-certs-and-configs.sh
)

conf_list.each do |file_present|
  describe file("#{file_present}") do
    it { should be_file }
    it { should be_mode 0640 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable.by('owner') }
    it { should be_readable.by('group') }
    it { should be_writable.by('owner') }
  end
end

describe file('/run/systemd/resolve/resolv.conf') do
  it { should be_symlink }
end

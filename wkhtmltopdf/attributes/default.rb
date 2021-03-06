if node['kernel']['machine'] == 'x86_64'
	default['wkhtmltopdf']['arch'] = 'amd64'
else
	default['wkhtmltopdf']['arch'] = 'i386'
end
default['wkhtmltopdf']['install_dir'] = "/usr/local/bin"
default['wkhtmltopdf']['mirror_url'] = "http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1.tar.bz2"

#default['wkhtmltopdf']['mirror_url'] = "http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb"
#default['wkhtmltopdf']['version'] = '0.10.0_rc2'
default['wkhtmltopdf']['version'] = '0.12.2.1'


# wkhtmltoimage
default['wkhtmltopdf']['wkhtmltoimage']['binary_extracted_name'] = "wkhtmltoimage-#{node['wkhtmltopdf']['arch']}"
default['wkhtmltopdf']['wkhtmltoimage']['binary_full_name'] = "wkhtmltoimage-#{node['wkhtmltopdf']['version']}-static-#{node['wkhtmltopdf']['arch']}"
default['wkhtmltopdf']['wkhtmltoimage']['binary_url'] = "#{node['wkhtmltopdf']['mirror_url']}/#{node['wkhtmltopdf']['wkhtmltoimage']['binary_full_name']}.tar.bz2"

# wkhtmltopdf
default['wkhtmltopdf']['wkhtmltopdf']['binary_extracted_name'] = "wkhtmltopdf-#{node['wkhtmltopdf']['arch']}"
default['wkhtmltopdf']['wkhtmltopdf']['binary_full_name'] = "wkhtmltopdf-#{node['wkhtmltopdf']['version']}-static-#{node['wkhtmltopdf']['arch']}"
default['wkhtmltopdf']['wkhtmltopdf']['binary_url'] = "#{node['wkhtmltopdf']['mirror_url']}/#{node['wkhtmltopdf']['wkhtmltopdf']['binary_full_name']}.tar.bz2"

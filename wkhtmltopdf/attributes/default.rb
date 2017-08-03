if node['kernel']['machine'] == 'x86_64'
	default['wkhtmltopdf']['arch'] = 'amd64'
else
	default['wkhtmltopdf']['arch'] = 'i386'
end
default['wkhtmltopdf']['install_dir'] = "/usr/local/bin"
#default['wkhtmltopdf']['mirror_url'] = "http://wkhtmltopdf.googlecode.com/files"
# default['wkhtmltopdf']['mirror_url'] = "http://download.gna.org/wkhtmltopdf/obsolete/linux"
# default['wkhtmltopdf']['mirror_url'] = "https://downloads.wkhtmltopdf.org/obsolete/linux"
default['wkhtmltopdf']['mirror_url'] = "https://cdn.conectaideas.com"
#default['wkhtmltopdf']['mirror_url'] = "http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1"
default['wkhtmltopdf']['version'] = '0.11.0_rc1'
#default['wkhtmltopdf']['version'] = '0.12.2.1'

# wkhtmltoimage
default['wkhtmltopdf']['wkhtmltoimage']['binary_extracted_name'] = "wkhtmltoimage-#{node['wkhtmltopdf']['arch']}"
default['wkhtmltopdf']['wkhtmltoimage']['binary_full_name'] = "wkhtmltoimage-#{node['wkhtmltopdf']['version']}-static-#{node['wkhtmltopdf']['arch']}"
default['wkhtmltopdf']['wkhtmltoimage']['binary_url'] = "#{node['wkhtmltopdf']['mirror_url']}/#{node['wkhtmltopdf']['wkhtmltoimage']['binary_full_name']}.tar.bz2"

# wkhtmltopdf
default['wkhtmltopdf']['wkhtmltopdf']['binary_extracted_name'] = "wkhtmltopdf-#{node['wkhtmltopdf']['arch']}"
default['wkhtmltopdf']['wkhtmltopdf']['binary_full_name'] = "wkhtmltopdf-#{node['wkhtmltopdf']['version']}-static-#{node['wkhtmltopdf']['arch']}"
default['wkhtmltopdf']['wkhtmltopdf']['binary_url'] = "#{node['wkhtmltopdf']['mirror_url']}/#{node['wkhtmltopdf']['wkhtmltopdf']['binary_full_name']}.tar.bz2"

# libwkhtmltox
default['wkhtmltopdf']['libwkhtmltox']['binary_extracted_name'] = "libwkhtmltox-#{node['wkhtmltopdf']['arch']}"
default['wkhtmltopdf']['libwkhtmltox']['binary_full_name'] = "libwkhtmltox-#{node['wkhtmltopdf']['version']}-static-#{node['wkhtmltopdf']['arch']}"
default['wkhtmltopdf']['libwkhtmltox']['binary_url'] = "#{node['wkhtmltopdf']['mirror_url']}/#{node['wkhtmltopdf']['libwkhtmltox']['binary_full_name']}.tar.bz2"

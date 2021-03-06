# original file: https://github.com/chef/chef/blob/0d097217dda26ac5551d1ad24132d9e53a62e0fb/lib/chef/platform/provider_mapping.rb
#
# Author:: Adam Jacob (<adam@opscode.com>)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class Chef
  class Platform
    class << self
      alias_method :old_platforms, :platforms
      def platforms
        @platforms ||= patch_platform(old_platforms)
      end

      def patch_platform(pf)
        pf[:redhat][:default][:service] = Chef::Provider::Service::Systemd
        pf[:redhat]["< 7"] ||= {}
        pf[:redhat]["< 7"][:service] = Chef::Provider::Service::Redhat

        pf[:centos][:default][:service] = Chef::Provider::Service::Systemd
        pf[:centos]["< 7"] ||= {}
        pf[:centos]["< 7"][:service] = Chef::Provider::Service::Redhat

        pf
      end
    end
  end
end

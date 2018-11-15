# Copyright 2017 Google Inc.
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

require 'vcr_config'

title 'GCP SSL policy resource test'

control 'gcp-ssl-policy-1.0' do

  impact 1.0
  title 'Ensure single SSL policy resource works.'
  VCR.use_cassette('gcp-ssl-policy') do
    resource = google_compute_zone({project: attribute('project_name'), name: attribute('ssl_policy')['name']})

    describe resource do
      it { should exist }
      its('min_tls_version') { should cmp attribute('ssl_policy')['min_tls_version'] }
      its('profile') { should cmp attribute('ssl_policy')['profile'] }
      its('custom_features') { should include attribute('ssl_policy')['custom_feature'] }
      its('custom_features') { should include attribute('ssl_policy')['custom_feature2'] }
    end
  end
end
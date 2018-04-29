require 'json'
require 'savon'

# to use you will need an api account and user credentials for a site.  
# must also know your site id

def find_mind_customer_id_by_email(email)
	site_ids = { 'int' => @SITEID }
	http_client = Savon.client("https://api.mindbodyonline.com/0_5/ClientService.asmx?WSDL")
	source_credentials = { 'SourceName' => 'CryoZone', 'Password' => '@PASSWORD', 'SiteIDs' => site_ids }
	user_credentials = { 'Username' => '@USERNAME', 'Password' => '@PASSWORD2', 'SiteIDs' => site_ids }
	http_request = { 'SourceCredentials' => source_credentials, 'UserCredentials' => user_credentials,
	'SearchText' => email}
	params = { 'Request' => http_request }
	
	result = http_client.request(:get_clients) do
		soap.body = params
	end
	
	@list_clients_now = result[:get_clients_response][:get_clients_result]
	puts @list_clients_now.inspect
	unique_id = @list_clients_now[:clients][:client].first[:unique_id]
end

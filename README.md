== README

NYTech
- A hub for NYTech professionals


<%= form_tag jobs_url, method: :get, id: 'job-filter-form', remote: true do %>



	<%= submit_tag "Search" %>
<% end %>
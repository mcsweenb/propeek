module JsonHelpers
  def json_response
    @json_response ||= JSON.parse(response.body, object_class: OpenStruct)
  end
end  

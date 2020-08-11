module ApiHelper
  def dispatch(method, path, headers = {})
    send method, path, headers
  end
end

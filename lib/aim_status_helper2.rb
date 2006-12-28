module AimStatusHelper2

  def aim_query(aim_name)
    Hash.from_xml Net::HTTP.get URI.parse("http://api.oscar.aol.com/SOA/key=ma139BMQR7QIGQ7o/resource-lists/users/*anonymous*/presence/~~/resource-lists/list%5Bname=%22users%22%5D/entry%5B%40uri=%22user:#{aim_name}%22%5D")    
  end

  def aim_status(aim_name)
    case aim_query(aim_name)['resource_lists']['list']['entry']['presence']['tuple']['presence_icon']
    when /online/
      @status = "online"
    when /offline/
      @status = "offline"
    when /away/
      @status = "away"
    when /idle/
      @status = "idle"
    end
  end

  def aim_status_icon(aim_name)
    image_tag "status_" + aim_status(aim_name) + ".png"
  end

  def aim_to(object, aim_name)
    link_to object, "aim:goim?screenname=#{aim_name}"
  end

end
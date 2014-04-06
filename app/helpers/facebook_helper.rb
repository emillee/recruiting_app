module FacebookHelper
  
  def fb_share(app_id, redirect_uri, opts={})
    o = {
      text: 'Share',
      name: 'name',
      display: '',
      caption: 'caption',
      description: 'desc',
      link: 'link',
      picture: 'pic',
      source: 'source',
      properties: {},
      actions: {}
    }.merge!(opts)
    
    opts_array = []
    
    opts.each do |key, val|
      case
        when key.to_s == 'properties'
          @prop = val.to_json
        when key.to_s == 'actions'
          @action = val.to_json
        else
          opts_array.push("#{key}=#{val}")
      end
    end
    
    url = "http://www.facebook.com/dialog/feed?app_id=#{app_id}&redirect_uri=#{redirect_uri}&#{opts_array.join('&')}&properties=#{@prop}&actions=#{@action}"
    link_to("#{o[:text]}", url)
  end
  
end
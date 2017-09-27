module KeyUtils
  def darksky_key
    @darksky_key ||= YAML::load(File.read('.config.yml'))['DARKSKY_API']
  end

  def zipcode_key
    @zipcode_key ||= YAML::load(File.read('.config.yml'))['ZIPCODE_API']
  end

end
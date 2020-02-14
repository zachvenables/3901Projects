#File created 9/26/2019 by Zachary Venables
# File edited 9/28 by Zach Venables
# File edited 10/1 by zach venables
# FIle edited 10/5 by zach venables
# File edited 10/6 by Matthew Kelch - Changed the directory to which files are saved


require "mechanize"
require "nokogiri"
require "fileutils"

IMAGE_FOLDER = "images/"


module GetPictures

  #Created 9/26 by Zach Venables
  #gets instructor photos from passed in ous.cse faculty page and returns them in an array
  def self.get_instructor_pics(page)
    instructor_pics = []
    hash = Hash.new

    instructor_names = get_instructor_names page

    #gets images with specific class name. saves the images in local folder and stores that name to an array
    page.images_with(class: "osu-profile-crop-large").each_with_index do |img, i|
      instructor_pics << img.fetch.save
    end

    # Move images to /images folder so they don't clutter the root directory
    instructor_pics.each_with_index do |image_path, i|
      image_extension = image_path[/(\.png|\.PNG|\.jpe?g|\.JPE?G)/]
      new_image_path = IMAGE_FOLDER + image_path + image_extension
      FileUtils.mv image_path, new_image_path
      instructor_pics[i] = new_image_path
    end

    #takes the name(key) and maps it to the stored photo name
    for i in 0...instructor_names.length
      hash[instructor_names[i]] = instructor_pics[i]
    end

    return hash
  end


  #Created 9/26 by Zach Venables
  # gets instructor name from osu.cse faculty page and returns in an array
  def self.get_instructor_names(page)
    names = [] 
    page.search("h2.person-name").each do |item|
      names << item.text
    end

    return names
  end

  #Created 10/5 by Zach Venables
  #gets instructor names and hashes with website
  def self.get_instructor_website (page)
    site = []

    page.links_with(text: "Website").each do |item|
      site << item.href
    end

    #inserting -1 vals for instructors with no site
    site.insert(9, -1)
    site.insert(20, -1)
    site.insert(34, -1)

    instructor_names = get_instructor_names page
    hash = Hash.new

    #puts instructor names with instructor sites
    for i in 0...instructor_names.length
      hash[instructor_names[i]] = site[i]
    end

    return hash
  end

end




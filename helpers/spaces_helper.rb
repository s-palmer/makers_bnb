module SpaceHelper
  


def generate_image
  number = [1, 2, 3, 4, 5].sample
  case number
  when 1
    "https://source.unsplash.com/800x600/?house"
  when 2
  "https://source.unsplash.com/800x600/?castle"
  when 3
    "https://source.unsplash.com/800x600/?villa"
  when 4
    "https://source.unsplash.com/800x600/?hotel"
  else
    "https://source.unsplash.com/800x600/?apartment"
  end
end

end
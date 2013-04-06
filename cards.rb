require 'prawn'
require "prawn/measurement_extensions"

Prawn::Document.generate("cards.pdf", page_size: [2.5.in, 3.5.in]) do
  font_families.update("Skia" => {
    :normal => "/Library/Fonts/Skia.ttf",
  })
  font "Skia"

  text_box "Loose Stone",
           size: 12,
           at: [0, margin_box.top],
           width: margin_box.width,
           align: :center

  text_box "Dig the card below for free.",
           size: 10,
           at: [0, margin_box.top-100],
           width: margin_box.width,
           align: :center
end

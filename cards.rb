require 'prawn'
require "prawn/measurement_extensions"

cards = [
  {
    name: "Loose Stone",
    description: "Dig the card below for free."
  },
  {
    name: "Fumble",
    description: "Drop a random dug item five cards down."
  }
]

Prawn::Document.generate("cards.pdf", page_size: [2.5.in, 3.5.in]) do
  font_families.update("Skia" => {
    :normal => "/Library/Fonts/Skia.ttf",
  })
  font "Skia"

  cards.each do |card|
    text_box card.fetch(:name),
             size: 12,
             at: [0, margin_box.top],
             width: margin_box.width,
             align: :center

    text_box card.fetch(:description),
             size: 10,
             at: [0, margin_box.top-100],
             width: margin_box.width,
             align: :center

    # FIXME: Extra page at end.
    start_new_page
  end
end

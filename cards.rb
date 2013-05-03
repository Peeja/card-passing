# encoding: utf-8

require 'prawn'
require 'prawn/measurement_extensions'
require 'yaml'

def cards
  YAML.load_file("cards.yml").map { |spec| [spec.fetch("card")] * spec.fetch("count") }.inject(:+)
end

class Enumerator
  def interspersing(intermission, &block)
    loop do
      yield self.next
      self.peek
      intermission.call
    end
  end
end

Prawn::Document.generate("cards.pdf", page_size: [5.in, 3.in], margin: 0) do
  font_families.update("Skia" => {
    :normal => "/Library/Fonts/Skia.ttf",
  })
  font "Skia"

  card_width, card_height = 1.67.in, 3.in
  margin = 2
  cards_per_row = 3
  rows_per_page = 1

  pages = cards.each_slice(cards_per_row).each_slice(rows_per_page)

  pages.each.interspersing(->{start_new_page}) do |page|
    page.each_with_index do |row, row_index|
      row.each_with_index do |card, column_index|
        box_right = column_index * (card_width + margin)
        box_top = margin_box.top - (row_index * (card_height + margin))

        bounding_box([box_right, box_top], width: card_width, height: card_height) do
          text_box card,
                   size: 10,
                   at: [10, card_height-90],
                   width: card_width-20,
                   align: :center
        end
      end
    end
  end
end


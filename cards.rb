# encoding: utf-8

require 'prawn'
require "prawn/measurement_extensions"

def cards
  [
    events,
    junk,
    gems,
    store_items
  ].inject(:+)
end

def events
  [
    {
      name: "Loose Stone",
      description: "Dig the card below for free."
    },
    {
      name: "Fumble",
      description: "Drop a random dug item five cards down."
    },
    {
      name: "Lucky Find",
      description: "Place the bottom card on top."
    },
    {
      name: "Cave In",
      description: "Drop dug card and put five junk cards on top."
    }
  ]
end

def junk
  [
    {
      name: "Dirt",
      description: "Takes 1 units of time to dig."
    },
    {
      name: "Stone",
      description: "Takes 2 units of time to dig."
    }
  ]
end

def gems
  [
    {
      name: "Ruby",
      description: "Value: ½ Card"
    },
    {
      name: "Saphire",
      description: "Value: 1 Card"
    },
    {
      name: "Emerald",
      description: "Value: 2 Cards"
    }
  ]
end

def store_items
  [
    {
      name: "Shovel",
      description: "Dig Dirt in no time."
    },
    {
      name: "Pickaxe",
      description: "Dig Stone in no time."
    },
    {
      name: "Cave In",
      description: "Drop dug card (if a player is digging) and put five junk cards on top."
    },
    {
      name: "Yoink",
      description: "Take an artifact as another player is digging it."
    },
    {
      name: "Switcheroo",
      description: "Swap any number of artifacts in your hand with an equal number from another player's."
    },
    {
      name: "Decent Forgery",
      description: "Play as part of any collection. Counts as an artifact in that collection."
    }
  ]
end


Prawn::Document.generate("cards.pdf", page_size: "LETTER") do
  font_families.update("Skia" => {
    :normal => "/Library/Fonts/Skia.ttf",
  })
  font "Skia"

  card_width, card_height = 2.5.in, 3.5.in
  margin = 2
  cards_per_row = 3
  rows_per_page = 3

  pages = cards.each_slice(cards_per_row).each_slice(rows_per_page)

  pages.each do |page|
    page.each_with_index do |row, row_index|
      row.each_with_index do |card, column_index|
        box_right = column_index * (card_width + margin)
        box_top = margin_box.top - (row_index * (card_height + margin))

        bounding_box([box_right, box_top], width: card_width, height: card_height) do
          stroke_bounds
          text_box card.fetch(:name),
                   size: 12,
                   at: [10, card_height-40],
                   width: card_width-20,
                   align: :center

          text_box card.fetch(:description),
                   size: 10,
                   at: [10, card_height-130],
                   width: card_width-20,
                   align: :center
        end
      end
    end

    # FIXME: Extra page at end.
    start_new_page
  end
end

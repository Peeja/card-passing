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

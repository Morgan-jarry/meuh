# coding: utf-8
require "rspec"
require "meuh"


RSpec::Matchers.define :be_one_of do |elements|
  match do |text|
    elements.any? { |element| element === text }
  end
  failure_message do |text|
    "expected #{text.inspect} to be in #{elements.inspect}"
  end
end


describe Meuh::Brain do
  let(:botname) { "M3uh" }
  let(:brain) { Meuh::Brain.new(botname: botname) }
  let(:nickname) { "sunny`" }
  let(:nicknames) { ["sunny`", "NaPs", "M3uh"] }

  it 'has a botname' do
    expect(brain.botname).to eq("M3uh")
  end

  it 'can change its botname' do
    brain.botname = "bar"
    expect(brain.botname).to eq("bar")
  end

  it 'never responds to !commands' do
    300.times { expect(msg("!foo")).to eq(nil) }
  end

  it 'reponds to questions addressed to its name' do
    possible_answers = ['ouais', 'euh ouais', 'vi', 'affirmatif', 'sans doute',
                        "c'est possible", "j'en sais rien moi D:", 'arf, non',
                        'non', 'nan', 'euh nan', 'negatif', 'euhh peut-être',
                        /^demande à (sunny`|NaPs)$/]
    100.times do
      expect(msg("et M3uh ça va ?")).to be_one_of(possible_answers)
    end
  end

  it 'reponds to its name' do
    possible_answers = ['3:-0', '', 'oui ?', '...', 'lol', 'mdr', ":')",
                        'arf', 'shhh', ':)', '3:)', 'tg :k',
                        "moi aussi je t'aime", "oui oui sunny`"]
    30.times do
      expect(msg("c'est la faute à M3uh")).to be_one_of(possible_answers)
    end
  end

  it 'responds to "lu"' do
    5.times {
      expect(msg("lu")).to be_one_of(["tin", "stucru"])
      expect(msg("lut")).not_to be_one_of(["tin", "stucru"])
    }
  end

  it 'responds to "quoi?"' do
    expect(msg("quoi?")).to eq("feur !")
    expect(msg("quoi ?")).to eq("feur !")
    expect(msg("voilà quoi")).not_to eq("feur !")
  end

  it 'responds to "hein?"' do
    expect(msg("hein?")).to eq("deux !!")
    expect(msg("hein ?")).to eq("deux !!")
    expect(msg("heing")).not_to eq("deux !!")
  end

  it 'responds to "où"' do
    expect(msg("où est ma tête ?")).to eq("dtc")
    expect(msg("où est la tienne ?")).to eq("dtc")
    expect(msg("où la tête de M3uh ?")).to eq("dtc")
    expect(msg("mais où donc ?")).not_to eq("dtc")
    expect(msg("où pas")).not_to eq("dtc")
  end

  it 'responds to lolz' do
    expect(msg("lOl")).to match(/^(lol|mdr|rofl|ptdr)$/)
    expect(msg("MDR")).to match(/^(lol|mdr|rofl|ptdr)$/)
    expect(msg("ptdr !!")).to match(/^(lol|mdr|rofl|ptdr)$/)
    expect(msg("mais MDR !")).not_to match(/^(lol|mdr|rofl|ptdr)$/)
  end

  it 'repeats when people change' do
    expect(msg("foobar", nickname: "bob")).not_to eq("foobar")
    expect(msg("foobar", nickname: "joe")).to eq("foobar")
    expect(msg("foobar", nickname: "ben")).not_to eq("foobar")
    expect(msg("foobar", nickname: "joe")).to eq("foobar")
  end

  it 'does not repeat when someone else repeats' do
    expect(msg("foobar", nickname: "joe")).not_to eq("foobar")
    expect(msg("foobar", nickname: "joe")).not_to eq("foobar")
    expect(msg("foobar", nickname: "joe")).not_to eq("foobar")
    expect(msg("foobar", nickname: "ben")).to eq("foobar")
  end

  it "talks randomly" do
    answer = nil
    300.times.find { answer = msg("hello") }
    expect(answer).to be_one_of([":)", ":p", "3:)", "lol"])
  end

  # Simplify sending a message with the given message
  def msg(message, options = {})
    defaults = { nickname: nickname, message: message, nicknames: nicknames }
    brain.message(defaults.merge(options)) do |answer|
      return answer
    end
    nil
  end
end

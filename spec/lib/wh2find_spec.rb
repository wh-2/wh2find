require 'rails_helper'

RSpec.describe Wh2find do
    describe "#get_bgrams_from" do
        context "when receieves text without repeated bgram" do 
            it "returns pure bgrams" do
                text = "batman"
                standardized = "_batman_"
                expect(Wh2find).to receive(:standardize).with(text).and_return(standardized)
                bgrams = Wh2find.get_bgrams_from text
                expect(bgrams).to eq ["_b", "ba", "at", "tm", "ma", "an", "n_"]
            end 
        end
        
        context "when receieves text with repeated bgrams" do 
            it "returns the second one with '" do
                text = "lala"
                standardized = "_lala_"
                expect(Wh2find).to receive(:standardize).with(text).and_return(standardized)
                bgrams = Wh2find.get_bgrams_from text
                expect(bgrams).to eq ["_l", "la", "al", "la'", "a_"]
            end 
        end

                
        context "when receieves text with bgrams repeated several times" do 
            it "add a ' for each repetition" do
                text = "lalaland"
                standardized = "_lalaland_"
                expect(Wh2find).to receive(:standardize).with(text).and_return(standardized)
                bgrams = Wh2find.get_bgrams_from text
                expect(bgrams).to eq ["_l", "la", "al", "la'", "al'", "la''", "an", "nd", "d_"]
            end 
        end

        context "when receives no standard text" do
            it "standardize" do
                text = "ñAm éåîòüç"
                standardized = "_nam_aeiou_"
                expect(Wh2find).to receive(:standardize).with(text).and_return(standardized)
                bgrams = Wh2find.get_bgrams_from text
                expect(bgrams).to eq ["_n", "na", "am", "m_", "_a", "ae", "ei", "io", "ou", "u_"]
            end
        end
    end
end
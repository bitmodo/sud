require File.expand_path('../base', __FILE__)

describe Sud do
    before(:each) do
        Sud.log_level = 'warn'
    end

    describe 'require_version' do
        it 'should succeed if valid range' do
            expect { described_class.require_version(Sud::VERSION) }.to_not raise_error
        end

        it 'should not succeed if bad range' do
            expect { described_class.require_version("> #{Sud::VERSION}") }.to raise_error(Sud::Errors::SudVersionBad)
        end
    end

    describe 'version' do
        it 'should succeed if valid range' do
            expect(described_class.version?(Sud::VERSION)).to be(true)
        end

        it 'should not succeed if bad range' do
            expect(described_class.version?("> #{Sud::VERSION}")).to be(false)
        end
    end
end

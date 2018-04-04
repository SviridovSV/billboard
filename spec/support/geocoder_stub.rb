module GeocoderStub
  Geocoder.configure(lookup: :test)

  Geocoder::Lookup::Test.add_stub(
    '24 tytova, dnipro, dnipropetrovsk, ukraine', [
      {
        'latitude'     => 40.7143528,
        'longitude'    => -74.0059731
      }
    ]
  )
end

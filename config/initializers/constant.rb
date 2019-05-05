ADMIN_EMAIL = 'zikriazzuri5@gmail.com'
SHIPPING_VENDORS = [
  { name: 'JNE Regular', base_price: 10000 },
  { name: 'JNE YES', base_price: 15000 },
  { name: 'J&T', base_price: 14000 }
]

_get_names = lambda {|h| h[:name].titleize }
PROVINCES = Indonesia.provinces.map(&_get_names).sort!
REGENCIES = Indonesia.provinces.inject({}) {|_hash, _p| (_hash[_p[:name].titleize] = Indonesia.regencies(_p[:id]).map(&_get_names).sort!) && _hash }
DISTRICTS = Indonesia.regencies.inject({}) {|_hash, _p| (_hash[_p[:name].titleize] = Indonesia.districts(_p[:id]).map(&_get_names).sort!) && _hash }

# injected_array => [3,4,2,3]
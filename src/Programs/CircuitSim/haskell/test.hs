genl :: Integer -> [Integer]
genl i = i:(genl (i + 1))


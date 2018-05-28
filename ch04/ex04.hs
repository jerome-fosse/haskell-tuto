import Data.List
import Data.Char (digitToInt)

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x

safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (x:xs) = Just xs

safeLast :: [a] -> Maybe a
safeLast [] = Nothing
safeLast xs = Just $ last xs

safeInit :: [a] -> Maybe [a]
safeInit [] = Nothing
safeInit xs = Just $ init xs

splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith _ [] = []
splitWith p xs = loop [] [] xs
    where loop curr acc [] = acc ++ [curr]
          loop curr acc (x:xs) | not $ p x = loop (curr ++ [x]) acc xs
                               | p x = loop [x] (newacc curr acc) xs
                                    where newacc [] acc = acc
                                          newacc curr acc = acc ++ [curr]

firstWords :: String -> IO()
firstWords str = printall $ map (\xs -> head xs) $ map words $ lines str
                    where printall [] = return ()
                          printall (x:xs) = putStrLn x >> printall xs

myMap :: ( a -> b) -> [a] -> [b]
myMap _ [] = []
myMap f xs = loop f xs []
      where loop _ [] acc = acc
            loop f (x:xs) acc = loop f xs $ acc ++ [(f x)]

mySum :: Num a => [a] -> a
mySum [] = 0
mySum xs = loop xs 0
      where loop [] acc = acc
            loop (x:xs) acc = loop xs $ acc + x


asInt :: String -> Int
asInt xs = loop 0 xs
      where loop acc [] = acc
            loop acc (x:xs) = let acc' = acc * 10 + digitToInt x
                  in loop acc' xs            

asInt2 :: String -> Int
asInt2 [] = error "Empty String"
asInt2 ['-'] = error "Not a number"
asInt2 ('-':xs) = negate $ asInt2 xs
asInt2 xs = foldl (\x y -> (x*10) + (digitToInt y)) 0 xs

type ErrorMessage = String
asIntEither :: String -> Either ErrorMessage Int
asIntEither [] = Left "Empty String"
asIntEither ['-'] = Left "Not a number"
asIntEither ('-':xs) = Right $ negate $ asInt2 xs
asIntEither xs = Right $ foldl (\x y -> (x*10) + (digitToInt y)) 0 xs

concat2 :: [[a]] -> [a]
concat2 xs = foldr (\x y -> x ++ y) [] xs

takeWhile2 :: (a -> Bool) -> [a] -> [a]
takeWhile2 _ [] = []
takeWhile2 f xs = loop xs []
      where loop [] acc = acc
            loop (x:xs) acc | f x = loop xs (acc ++ [x])
                            | not $ f x = acc

takeWhile3 :: (a -> Bool) -> [a] -> [a]
takeWhile3 f xs = foldr (\x acc -> if f x then x : acc else []) [] xs
                            
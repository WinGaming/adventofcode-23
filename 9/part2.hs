split :: String -> Char -> [String]
split [] _ = [""]
split (c:cs) p | c == p = "" : rest
               | otherwise = (c : head rest) : tail rest
      where rest = split cs p

append :: Int -> [Int] -> [Int]
append a = foldr (:) [a]

showLine :: [Int] -> String
showLine [] = ""
showLine [c] = show c
showLine (c:cs) = show c ++ " " ++ showLine cs

showLines :: [[Int]] -> String
showLines []  = ""
showLines [c] = showLine c
showLines (c:cs) = showLine c ++ " | " ++ showLines cs

parseInt :: String -> Int
parseInt val = read val :: Int

parseLine :: String -> [Int]
parseLine line = map parseInt (split line ' ')

isFinalLine :: [Int] -> Bool
isFinalLine [] = True
isFinalLine (c:cs) = c == 0 && isFinalLine cs

calculateNextLine :: [Int] -> [Int]
calculateNextLine [] = []
calculateNextLine [c] = []
calculateNextLine (c:cs) = (head cs - c):calculateNextLine cs

--Breaks down the last line and adds it to the result
breakdownLines :: [[Int]] -> [[Int]]
breakdownLines [] = []
breakdownLines line
  | isFinalLine (last line) = line
  | otherwise = line ++ breakdownLines [calculateNextLine (last line)]

-- This method appends a 0 to the last line
initialSolve :: [[Int]] -> [[Int]]
initialSolve lines = init lines ++ [last lines ++ [0]]

solve :: [[Int]] -> Int
solve [c] = head c       -- We have already solved all lines, so we can just return the last one
solve lines = solve (init (init lines) ++ [(head (last (init lines)) - head (last lines)) : last (init lines)])

bundle :: a -> [a]
bundle e = [e]

solveLines :: [String] -> [Int]
solveLines = map (solve . initialSolve . breakdownLines . bundle . parseLine)

main :: IO ()
main = do
  contents <- readFile "input.txt"
--  print (split contents '\n')
--  print (isFinalLine (parseLine (head (split contents '\n'))))
--  print (isFinalLine (calculateNextLine (parseLine (head (split contents '\n')))))
--  print (isFinalLine (calculateNextLine (calculateNextLine (parseLine (head (split contents '\n'))))))
--  print (init (parseLine (head (split contents '\n'))))
--  print (showLines [parseLine (head (split contents '\n')), parseLine (head (split contents '\n'))])
--  print (showLines (breakdownLines [parseLine (head (split contents '\n'))]))
--  print (showLines (initialSolve (breakdownLines [parseLine (head (split contents '\n'))])))
--  print (solve (initialSolve (breakdownLines [parseLine (head (split contents '\n'))])))
--  print (show (solveLines (split contents '\n')))
  print (show (sum (solveLines (split contents '\n'))))
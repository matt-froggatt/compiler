module Interpreter where

import Prelude
import Parser

interpret :: [Expr] -> IO()
interpret ((Function (ID "print") args):rest) = print args >> interpret rest

interpret [] = print "Done!"

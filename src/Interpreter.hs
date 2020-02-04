module Interpreter where

import Prelude
import Parser

interpret [(Function (ID "print") b)] = print b

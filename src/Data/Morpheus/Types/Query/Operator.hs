module Data.Morpheus.Types.Query.Operator
  ( Operator(..)
  , ValidOperator
  , RawOperator
  , Variable(..)
  , VariableDefinitions
  , TypeWrapper(..)
  , Operator'(..)
  , ValidOperator'
  , RawOperator'
  ) where

import           Data.Morpheus.Types.Core               (Collection, Key)
import           Data.Morpheus.Types.MetaInfo           (Position)
import           Data.Morpheus.Types.Query.RawSelection (RawSelectionSet)
import           Data.Morpheus.Types.Query.Selection    (Arguments, SelectionSet)

type ValidOperator = Operator Arguments SelectionSet

type ValidOperator' = Operator' Arguments SelectionSet

data TypeWrapper
  = ListType
  | NonNullType
  deriving (Show)

data Variable = Variable
  { variableType         :: Key
  , isVariableRequired   :: Bool
  , variableTypeWrappers :: [TypeWrapper]
  , variablePosition     :: Position
  }

type VariableDefinitions = Collection Variable

type RawOperator = Operator VariableDefinitions RawSelectionSet

type RawOperator' = Operator' VariableDefinitions RawSelectionSet

data Operator' args sel = Operator'
  { operatorName      :: Key
  , operatorArgs      :: args
  , operatorSelection :: sel
  , operatorPosition  :: Position
  }

data Operator args sel
  = Query (Operator' args sel)
  | Mutation (Operator' args sel)
  | Subscription (Operator' args sel)
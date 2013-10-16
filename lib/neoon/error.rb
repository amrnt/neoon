module Neoon
  module Error

    class Exception < StandardError
      attr_reader :response

      def initialize(response, message)
        @response = response
        super(message)
      end
    end

    class IndexException < Exception; end
    class SchemaException < Exception; end
    class CypherException < Exception; end

    # custom
    class NodeNotFoundException < Exception; end

    # org.neo4j.kernel.impl.api.constraints
    class ConstraintValidationKernelException < Exception; end
    class UnableToValidateConstraintKernelException < Exception; end
    class UniqueConstraintViolationKernelException < Exception; end

    # org.neo4j.kernel.api.exceptions
    class BeginTransactionFailureException < Exception; end
    class ConstraintCreationException < Exception; end
    class EntityNotFoundException < Exception; end
    class KernelException < Exception; end
    class LabelNotFoundKernelException < Exception; end
    class PropertyKeyIdNotFoundKernelException < Exception; end
    class PropertyKeyNotFoundException < Exception; end
    class PropertyNotFoundException < Exception; end
    class RelationshipTypeIdNotFoundKernelException < Exception; end
    class TransactionalException < Exception; end
    class TransactionFailureException < Exception; end

    # org.neo4j.kernel.api.exceptions.index
    class ExceptionDuringFlipKernelException < IndexException; end
    class FlipFailedKernelException < IndexException; end
    class IndexNotFoundKernelException < IndexException; end
    class IndexPopulationFailedKernelException < IndexException; end
    class IndexProxyAlreadyClosedKernelException < IndexException; end

    # org.neo4j.kernel.api.exceptions.schema
    class AddIndexFailureException < SchemaException; end
    class AlreadyConstrainedException < SchemaException; end
    class AlreadyIndexedException < SchemaException; end
    class CreateConstraintFailureException < SchemaException; end
    class DropConstraintFailureException < SchemaException; end
    class DropIndexFailureException < SchemaException; end
    class IllegalTokenNameException < SchemaException; end
    class IndexBelongsToConstraintException < SchemaException; end
    class IndexBrokenKernelException < SchemaException; end
    class MalformedSchemaRuleException < SchemaException; end
    class NoSuchConstraintException < SchemaException; end
    class NoSuchIndexException < SchemaException; end
    class SchemaAndDataModificationInSameTransactionException < SchemaException; end
    class SchemaKernelException < SchemaException; end
    class SchemaRuleNotFoundException < SchemaException; end
    class TooManyLabelsException < SchemaException; end

    # org.neo4j.cypher.CypherException
    class CypherExecutionException < CypherException; end
    class UniquePathNotUniqueException < CypherException; end
    # class EntityNotFoundException < CypherException; end
    class CypherTypeException < CypherException; end
    class IterableRequiredException < CypherException; end
    class ParameterNotFoundException < CypherException; end
    class ParameterWrongTypeException < CypherException; end
    class PatternException < CypherException; end
    class InternalException < CypherException; end
    class MissingIndexException < CypherException; end
    class MissingConstraintException < CypherException; end
    class InvalidAggregateException < CypherException; end
    class NodeStillHasRelationshipsException < CypherException; end
    class ProfilerStatisticsNotReadyException < CypherException; end
    class UnknownLabelException < CypherException; end
    class IndexHintException < CypherException; end
    class LabelScanHintException < CypherException; end
    class UnableToPickStartPointException < CypherException; end
    class InvalidSemanticsException < CypherException; end
    class OutOfBoundsException < CypherException; end
    class MergeConstraintConflictException < CypherException; end

  end
end

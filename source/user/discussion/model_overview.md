---
title: Interpretation Model Overview
description: The overall structure of ClinGen interpretations, and the use of W3C-Prov.
model: interpretation

---

TODO: go through here and link to e.g. Entity, EvidenceSTatementSource, ...

Introduction
------------

An interpretation is the outcome of structured reasoning applied to evidence.   Interpretations may be made about many kinds of entities using many kinds of evidence, and different formalized reasoning strategies.  Although the overall structure of an interpretation is the same for many cases, the initial version of the interpretation model is limited to interpretations of the pathogenicity of sequence variants using the [ACMG Pathogenicity Guidelines]().   The discussion below will specifically use this context as an example, but the structure of the model is expected to remain largely unchanged as new interpretation contexts are added.

The process of generating this type of interpretation is composed of three kinds of activities:

    1. Collecting various forms of evidence from potentially many sources such as literature or databases
    2. Application of individual ACMG Guideline Criteria, in which subsets of this evidence are combined to draw conclusions about lines of evidence
    3. Combination of these conclusions to create an overall interpretation of the evidence: a statement about the pathogenicity of a given allele.

The process is visualized here as a tree.  The root of the tree is the interpretation, and it depends on the conclusions of individual ACMG criteria, and those in turn depend on the evidence (the leaves of the tree).

FIGURE 

An interpretation without the supporting evidence and reasoning is merely an assertion by somebody.  Inclusion of the evidence and reasoning allows the receiver to draw their own conclusions, and to reasonably build upon the work carried out by an interpretations original creators.

W3C-Prov
--------

The interpretation model, therefore must contain not only interpretations, but structured information about the evidence and criteria used to create the interpretation, along with metadata about who performed atomic activities and when.  W3C-Prov provides such a structure.

[W3C-Prov]() is a specification for defining the provenance of objects. That is, given an object, this framework provides a standard way to say
    * who generated (created) the object 
    * when they generated it
    * what type of activity was used to generate it
    * which other objects were used in the generation

W3C-Prov is composed of three types: Entity, Activity, and Agent.  Entities are simply the things in the model.  In the interpretation model, the entities are
    * An interpretation (e.g. An allele is pathogenic for a given condition)
    * An Assessed Criteria (e.g. PP2 for a given allele and condition provides supporting evidence of pathogenicity)
    * Evidence Statements (e.g. a population frequency of an allele, segregation data, prevalence of a condition)
    * Evidence Sources (e.g., Publications, database records)
Entities have provenance; each was generated by a particular Activity.  

Activities are an action that lasted for a particular time range, which used some entities to generate other entities.  In the interpretation model, the activities correspond to those listed above: 
    * Evidence capture, which uses Evidence Sources to generate Evidence Statements
    * Criteria Assessment, which uses Evidence Statements to generate AssessedCriteria
    * GenerateInterpretation which uses AssessedCriteria to generate Interpretations
W3C-Prov activities then become linkers between the different levels of our tree.

Agents are associated with Activities and entities, and answer the question of who performed the activity.  Agents may be individuals, but may also be groups, such as an expert panel, or a software agent, such as one that automatically loads evidence from a source.

Including Entities, Activities, and Agents into the interpretation figure above, we have the following:

FIGURE

Discussion
----------

Using the W3C-Prov framework allows specification of the model to be organized into Entities, Activities, and Agents.  The remaining documentation is broken down according to this breakdown.

The model is loosely coupled; individual entities have at least a conceptual existence outside a given interpretation, so that the same piece of evidence that is generated for one interpretation may be retained, along with its provenance, and used in later interpretations.  

The tree structure of the model is collapsible.  If a user is interested only in the final interpretation, they need to simply access the root node of the structure.  Suppose however, that a user has a discrepant interpretation.  The initial question in such a case would be "which ACMG criteria were used to generate the interpretation?"  The user can answer this question by moving one level in the provenance graph to see which entities were used by the GenerateInterpretation activity.  Suppose further that most of these assessments concur with the users' but that one is not.  Then the user may inspect the branch of the tree corresponding to that conflicting assessment, allowing inspection of the particular evidence and where that evidence came from.

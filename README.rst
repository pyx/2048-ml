=============
2048 in OCaml
=============


Introduction
============

A clone of `2048`_, implemented in `OCaml`_.

.. _2048: https://github.com/gabrielecirulli/2048/
.. _OCaml: http://ocaml.org/


Features
--------

- Cross-platform GUI with no external dependency, using graphics library that
  comes with OCaml
- Text (ascii) output as well
- Gameplay actions implemented as *monadic functions*, for example, to place
  two new tiles:

  .. code:: ocaml

    playing board >>= spawn >>= spawn


Requirements
============

To compile

- `OCaml`_ 4.01 or newer.


Installation
============

Gentoo
------

There are ebuilds come with 2048-ml for each tagged release.

They can also be found (along with Manifest) in my personal overlay:

Mercurial:
  https://bitbucket.org/pyx/overlay

Git:
  https://github.com/pyx/overlay.git

With properly added ebuild:

.. code:: bash

  emerge --ask 2048-ml


From Source
-----------

Compile

.. code:: bash

  make

Install

.. code:: bash

  make install


License
=======

BSD New, see LICENSE for details.


Links
=====

Project:
  http://xrefactor.com/projects/2048-ml

Issue Tracker:
  https://bitbucket.org/pyx/2048-ml/issues/

Mercurial Repository on Bitbucket:
  https://bitbucket.org/pyx/2048-ml/

Git Repository on Github:
  https://github.com/pyx/2048-ml/

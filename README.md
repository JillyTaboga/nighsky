# nighsky

Um projeto de estudo sobre a injeção de dependencias com o Riverpod feito em 6 horas

## Objetivos

Divisão minimalista em uma arquitetura clean, sem utilização de progamação funcional para tratar erros, mas com implementação de dataSources -> repositories -> useCases -> controllers -> interface buscando utilizar o Riverpod e seus diversos tipos de provider.

## Observações interessantes

- A utilização do FutureProvider como use case é bem interessante já fornecendo o prático .when para tratar loading, erros e o data, deixando o StateNotifierProvider necessário somente para casos mais complexos
- A injeção com meros Providers oferece grande facilidade de injeção para testes personalizados uma vez que qualquer provider na linha poderia ser alterado ou mockado
- Ao utilizar o ConsumerWidget ou sua versão stateful você tem acesso ao Ref e seus providers em qualquer lugar, tornando completamente desnecessário a passagem de data entre widgets, contudo um estudo mais aprofundado (em um app com mais telas) pode ser necessário para se perceber as limitações e perigos de tais abordagens em combinações com o autodispose e o family dos providers para se evitar sigletons
- Com o FutureProvider e o tratamento de erros através de throw no repository não vejo necessidade da implementação de um tratamento de erros funcional como o Either do Dartz

## Exemplo

<https://nightskytime.web.app>

A interface pensada foi minimalista para focar apenas no objetivo do projeto

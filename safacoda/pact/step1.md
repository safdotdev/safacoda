## Get started with pact

`cd ~/path-to-pact-nirvana`{{exec}}

1. `cd ./Step_01_WriteYourFirstPact`{{exec}}
2. `npm run test:consumer`{{exec}}
3. `cd ./Step_02_VerifyYourFirstPactLocally`{{exec}}
4. `npm run test:provider`{{exec}}
5. `cd ./Step_02_VerifyYourFirstPactLocally`{{exec}}
6. `cd ./Step_03_GetAPactBroker`{{exec}}
7. `docker-compose up -d`{{exec}}
8. `cd ./Step_04_PublishYourFirstPactLocally`{{exec}}
9. `make doctor`{{exec}}
10. `make publish_docker`{{exec}}
11. `cd ./Step_05_VerifyYourFirstPactFromABrokerLocally`
12. `make npm run test:provider`{{exec}}
13. `cd ./Step_06_PublishYourFirstPactFromCI`
14. `make ci`{{exec}}
15. `cd ./Step_07_VerifyYourFirstPactFromCI`
16. `make ci`{{exec}}
17. `cd ./Step_08_AddCanIDeployForProvider`
18. `make can_i_deploy`{{exec}}
19. `cd ./Step_09_AddRecordDeploymentForProvider`
20. `make record_deployment`{{exec}}
21. `cd ./Step_10_AddCanIDeployForConsumer`
22. `make can_i_deploy`{{exec}}
23. `cd ./Step_11_AddRecordDeploymentForConsumer`
24. `make record_deployment`{{exec}}
25. `cd ./Step_13_CompleteBuild`{{exec}}
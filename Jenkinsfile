#!/usr/bin/env groovy

env.ROS_DISTRO = 'kinetic'
env.CCACHE_DIR = '/jobcache/ccache'
def server = Artifactory.server 'sixriver'

parallel(
    failFast: true,
    "arm64" : {
        node('docker && bigarm64') {
            def customImage = ""
            def scmVars = ""
            
            stage("arm64 Build Docker Image") {
                scmVars = checkout scm
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'artifactory_apt',
                        usernameVariable: 'ARTIFACTORY_USERNAME', passwordVariable: 'ARTIFACTORY_PASSWORD']]) {
                    customImage = docker.build("gcr.io/plasma-column-128721/pkg-builder:arm64", " --file arm64/Dockerfile --build-arg ARTIFACTORY_USERNAME=${env.ARTIFACTORY_USERNAME} --build-arg ARTIFACTORY_PASSWORD=${env.ARTIFACTORY_PASSWORD} ." )
                }  
            }
            
            stage("Upload Image to Gcloud") {
              docker.image('arm64v8/docker').inside('-u 0:0 -v /var/run/docker.sock:/var/run/docker.sock') {
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'gcr-login',
                        usernameVariable: 'GCR_USERNAME', passwordVariable: 'GCR_PASSWORD']]) {
                  sh '''
                  docker login -u "${GCR_USERNAME}" -p "${GCR_PASSWORD}"  https://gcr.io
                  docker push gcr.io/plasma-column-128721/pkg-builder:arm64
                  '''
                }
              }
            }
        }
    },
    "amd64" : {
        node('docker && amd64') {
            def customImage = ""
            def scmVars = ""
            
            stage("amd64 Build Docker Image") {
                scmVars = checkout scm
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'artifactory_apt',
                        usernameVariable: 'ARTIFACTORY_USERNAME', passwordVariable: 'ARTIFACTORY_PASSWORD']]) {
                    customImage = docker.build("gcr.io/plasma-column-128721/pkg-builder:amd64", " --file amd64/Dockerfile --build-arg ARTIFACTORY_USERNAME=${env.ARTIFACTORY_USERNAME} --build-arg ARTIFACTORY_PASSWORD=${env.ARTIFACTORY_PASSWORD} ." )
                }  
            }
            
            stage("Upload Image to Gcloud") {
              docker.image('arm64v8/docker').inside('-u 0:0 -v /var/run/docker.sock:/var/run/docker.sock') {
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'gcr-login',
                        usernameVariable: 'GCR_USERNAME', passwordVariable: 'GCR_PASSWORD']]) {
                  sh '''
                  docker login -u "${GCR_USERNAME}" -p "${GCR_PASSWORD}"  https://gcr.io
                  docker push gcr.io/plasma-column-128721/pkg-builder:amd64
                  '''
                }
              }
            }
        }
    }
)
#!/usr/bin/env groovy

env.ROS_DISTRO = 'kinetic'
env.CCACHE_DIR = '/jobcache/ccache'
def server = Artifactory.server 'sixriver'

parallel(
    failFast: true,
    "arm64" : {
        node('docker && arm64') {
            def customImage = ""
            def scmVars = ""
            
            stage("arm64 Build Docker Image") {
                scmVars = checkout scm
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'artifactory_apt',
                        usernameVariable: 'ARTIFACTORY_USERNAME', passwordVariable: 'ARTIFACTORY_PASSWORD']]) {
                    customImage = docker.build("gcr.io/plasma-column-128721/ros-builder:arm64", " --file arm64/Dockerfile --build-arg ARTIFACTORY_USERNAME=${env.ARTIFACTORY_USERNAME} --build-arg ARTIFACTORY_PASSWORD=${env.ARTIFACTORY_PASSWORD} ." )
                }  
            }
        }
    }
)
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")

    val fixNamespace = Action<Project> {
        val androidExtension = extensions.findByName("android")
        if (androidExtension != null) {
            val android = androidExtension as? com.android.build.gradle.BaseExtension
            if (android?.namespace == null) {
                android?.namespace = project.group.toString()
            }
        }
    }

    if (project.state.executed) {
        fixNamespace.execute(project)
    } else {
        project.afterEvaluate { fixNamespace.execute(this) }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

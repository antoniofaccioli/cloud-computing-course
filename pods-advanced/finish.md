# Well done

You have written a manifest that combines all three container patterns covered in this lesson:

- An **init container** that prepares the environment before the application starts
- A **main container** (nginx) that serves content produced by the init container
- A **sidecar** that runs alongside the main container and monitors the shared volume

The answer to the key question: the new init container does **not** see the file written by the previous one. The `emptyDir` volume is destroyed when the Pod is deleted and a brand new empty directory is created when the Pod is recreated. The init container always starts from scratch — which is exactly why it exists.

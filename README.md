# The Cloud Resume Challenge - Azure

This is based on the challenge set out here: <https://cloudresumechallenge.dev/docs/the-challenge/azure/> 

This requires touching multiple parts of the Azure cloud infrastructure, increasing familiarity and understanding of how "The Cloud" works.

## Result

The result of this challenge can be seen by browsing to <https:www.patrickdevane.co>

## Technologies

This challenge uses the following parts:

### The Frontend

- Azure Storage - to host the static website files
- Azure FrontDoor and CDN - to map the static file host to a custom domain and provide caching for faster delivery

### The Backend

- Azure Cosmos DB (Table API) - Tbis keeps track of the number of visitors to the site
- Azure Storage - to host the files for the Azure Function
- Azure Function - a small python API to retrieve and increment the number of visitors on each page load

### Other

- Custom domain - buying a custom domain name from GoDaddy
- DNS - Creating a custom CNAME record in GoDaddy for mapping the custom domain to the Azure static file share
- Bicep files - to source control the infrastrucutre (Infrastrucutre As Code)
- GitHub Actions - to automatically update the system when changes are made

## Challenges

### Custom Domain and DNS

I have previously used Azure Storage for hosting static websites, but I had never configured a custom domain before. There were issues trying to get my local Safari browser to resolve the custom <https://www.patrickdevane.co> site as it kept telling me there was no server.

Initially I suspected that this was because of the A (Alias) record in GoDaddy that showed that the domain name was "parked" but even after deleting this there was no success. I performed an NSLookup on the domain and it appeared to resolve via Azure FrontDoor as expected, so I tried via Chrome and the site resolved. Once I flushed the chaches in Safari, that too, resolved.

### Azure Function Development

#### The Problem

I performed the majority of this challenge using an Apple Silicon MacBook. This meant that I had issues with running Azure functions locally as they are technically not supported on ARM_64 architectures. This is a problem because deploying a function from the Azure plugin in VSCode reuqired having it run locally so that Azure knows the function _can_ be deployed.

#### Attempt 1: Duplicating the terminal

In the past, this issue has been worked around by duplicating terminal and setting it to run with Rosetta (on x86 / x64 emulation). This is no longer possible as of MacOSX Ventura. 

#### Attempt 2: Dev containers

A second workaround was to use dev containers explicitly to run the Azure function locally. Because this also relied on emulation (via Docker desktop) the continer took too long to instal the required dependancies into it (VSCode plugins for Azure functions and python) although with enough time, it looked like this would work.

#### Attempt 3: gRPC file copy

Luckily there is a workaround involving copying a specific file and modifying it. This worked in my case (see [this link](https://github.com/Azure/azure-functions-core-tools/issues/2834#issuecomment-1206135712) for more details.

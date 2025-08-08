# Contributing to Registry Keys

We welcome contributions from the community to help grow this collection of registry keys for open-source applications. Your help is essential for keeping this repository up-to-date and comprehensive.

## How to Contribute

There are several ways you can contribute to this project:

- **Adding a new application:** If you have information about an application that is not yet in our collection, please follow the steps below to add it.
- **Updating existing information:** If you find that the information for an application is outdated or incomplete, you can submit a pull request with the necessary changes.
- **Reporting issues:** If you find any problems with the repository, such as incorrect information or broken links, please open an issue.

## Adding a New Application

To add a new application to the collection, please follow these steps:

1.  **Fork the repository:** Start by forking the repository to your own GitHub account.
2.  **Create a new file:** In the `windows/` directory, create a new markdown file for the application. The filename should be the application's name in lowercase (e.g., `notepadplusplus.md`).
3.  **Follow the template:** Use the following template to structure the information in the new file. Make sure to fill in all the relevant details.

    ```markdown
    # Application Name

    **Version tested:** [Version number]
    **Installer type:** [e.g., .exe, .msi, portable]

    ## 📁 Registry Paths

    - `[Full registry path]`
    - `[Another full registry path, if applicable]`

    ## 🔑 Keys

    | Key Name      | Type        | Description                               |
    |---------------|-------------|-------------------------------------------|
    | `ExampleKey`  | `REG_SZ`    | A brief description of what this key does.|
    | `AnotherKey`  | `REG_DWORD` | Another example key.                      |

    ## 📝 Notes

    - Any additional notes or observations go here.
    ```

4.  **Submit a pull request:** Once you have created the new file, commit your changes and submit a pull request. We will review your contribution and merge it if everything is correct.

## Code of Conduct

Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms. We are committed to fostering an open and welcoming environment.

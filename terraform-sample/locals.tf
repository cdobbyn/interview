locals {
  #
  unclean_fileset = fileset(var.absolute_path, "**/${var.metafile}")

  #
  clean_fileset = [for file in local.unclean_fileset : (
  "${var.workspace_path}/${file}"
  ) if !contains(split("/", file), "_template")]

  #
  workspaces = { for file in local.clean_fileset : (
  #
  replace(     #
    replace(   #
      replace( #
        file, "/${var.metafile}", ""
      ),
      "${var.workspace_path}/", ""
    ),
    "/", "-")
  ) => (
  #
  merge(
    #
    yamldecode(file(
      #
      replace(file, var.workspace_path, var.absolute_path)
    )),

    #
    { working_directory = replace(file, "/${var.metafile}", "") }
  )
  )
  }
}

terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.60.1"
    }
    inwx = {
      source  = "inwx/inwx"
      version = "1.6.4"
    }
  }

  encryption {
    ## Step 1: Add the desired key provider:
    key_provider "pbkdf2" "pbkdf2_key_provider" {
      passphrase = var.passphrase
    }
    ## Step 2: Set up your encryption method:
    method "aes_gcm" "aes_gcm_method" {
      keys = key_provider.pbkdf2.pbkdf2_key_provider
    }

    state {
      ## Step 3: Link the desired encryption method:
      method = method.aes_gcm.aes_gcm_method

      ## Step 4: Run "tofu apply".

      ## Step 5: Consider adding the "enforced" option:
      enforced = true
    }

    ## Step 6: Repeat steps 3-5 for plan{} if needed.
    plan {
      ## Step 3: Link the desired encryption method:
      method = method.aes_gcm.aes_gcm_method

      ## Step 4: Run "tofu apply".

      ## Step 5: Consider adding the "enforced" option:
      enforced = true
    }
  }
}

# Authentication via HCLOUD_TOKEN env var
provider "hcloud" {}

# Authentication via INWX_USERNAME, INWX_PASSWORD env vars
provider "inwx" {}

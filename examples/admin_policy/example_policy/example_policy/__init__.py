"""Example admin policy module and prebuilt policies."""
from example_policy.client_policy import UseLocalGcpCredentialsPolicy
from example_policy.skypilot_policy import AddLabelsConditionalPolicy
from example_policy.skypilot_policy import AddLabelsPolicy
from example_policy.skypilot_policy import AddVolumesPolicy
from example_policy.skypilot_policy import DisablePublicIpPolicy
from example_policy.skypilot_policy import DoNothingPolicy
from example_policy.skypilot_policy import DynamicKubernetesContextsUpdatePolicy
from example_policy.skypilot_policy import EnforceAutostopPolicy
from example_policy.skypilot_policy import GPUStaticQuotaPolicy
from example_policy.skypilot_policy import RateLimitLaunchPolicy
from example_policy.skypilot_policy import RejectAllPolicy
from example_policy.skypilot_policy import SetMaxAutostopIdleMinutesPolicy
<<<<<<< HEAD
=======
from example_policy.skypilot_policy import SlurmFilesystemRoutingPolicy
>>>>>>> fed792080c42a72ae783801ee7ac311c86a4e1ac
from example_policy.skypilot_policy import SlurmPartitionRoutingPolicy
from example_policy.skypilot_policy import UseSpotForGpuPolicy

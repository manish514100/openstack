resource "openstack_identity_project_v3" "project_name" {
  name = var.project_name
  description = var.project_description
}

resource "openstack_identity_user_v3" "project_username" {
  name               = var.project_username
  default_project_id = openstack_identity_project_v3.project_name.id
  password = var.project_user_password
}

#resource "openstack_identity_role_v3" "role_name" {
#  name = var.role_name
#}

data "openstack_identity_role_v3" "member" {
name = "_member_"
}   

resource "openstack_identity_role_assignment_v3" "role_assignment" {
  user_id    = "${openstack_identity_user_v3.project_username.id}"
  project_id = "${openstack_identity_project_v3.project_name.id}"
  role_id    = "${data.openstack_identity_role_v3.member.id}"
}

data "openstack_identity_role_v3" "lb_member" {
  name = "load-balancer_member"
}

resource "openstack_identity_role_assignment_v3" "role_assignment2" {
  user_id    = "${openstack_identity_user_v3.project_username.id}"
  project_id = "${openstack_identity_project_v3.project_name.id}"
  role_id    = "${data.openstack_identity_role_v3.lb_member.id}"
}

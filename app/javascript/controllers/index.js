// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)

import MemberCardController from "./membercard_controller"
import NewMessageFormController from "./new_message_form_controller"
import ChannelSidebar from "./channel_sidebar_controller"
import ChannelToolbar from "./channel_toolbar_controller"
import Loading from "./loading_controller"
import InvitationUrl from "./invitation_url_controller"
import NewChannelModal from "./new_channel_modal_controller"

application.register("membercard", MemberCardController)
application.register("new_message_form", NewMessageFormController)
application.register("channelSidebar", ChannelSidebar)
application.register("channelToolbar", ChannelToolbar)
application.register("loading", Loading)
application.register("invitation-url", InvitationUrl)
application.register("new-channel-modal", NewChannelModal)

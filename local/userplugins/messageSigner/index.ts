import definePlugin from "@utils/types";

export default definePlugin({
    name: "MessageSigner",
    description: "Automatically signs off all messages",
    authors: [
        {
            name: "Piny",
            id: 0n
        }
    ],

    onBeforeMessageSend(channelId, msg) {
        msg.content = msg.content + "\n- Piny"
    },
})

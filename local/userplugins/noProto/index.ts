import definePlugin from "@utils/types";

export default definePlugin({
    name: "NoProtocol",
    description: "Removes protocol from URLs in messages by used masked links.",
    authors: [{
        name: 'Piny',
        id: 900126154881646634n
    }],

    onBeforeMessageSend(channelId, msg) {
        // Replace all URI's with masked links (eg. https://google.com -> [google.com](https://google.com). Same for any other protocol like wss://)
        const supportedProtocols = ['http', 'https', 'ftp', 'ws', 'wss'];

        let content = msg.content;

        for (const protocol of supportedProtocols) {
            const regex = new RegExp(`\\b(${protocol}:\/\/[a-zA-Z0-9-._~:/?#[\\]@!$&'()*+,;=]+)\\b`, 'g');
            content = content.replace(regex, (match, p1) => {
                const urlWithoutProtocol = p1.replace(`${protocol}://`, '');
                return `[${urlWithoutProtocol}](${p1})`;
            });
        }

        msg.content = content;
    },
});
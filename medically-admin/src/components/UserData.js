

const UserData = ({ users, searchKey }) => {


    return (
        <table className="data-table">
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Balance</th>
            </tr>
            {users.map((user, index) => {
                if (user.name.toLowerCase().includes(searchKey.toLowerCase()) || user.email.toLowerCase().includes(searchKey.toLowerCase())) {
                    return (
                        <tr key={index}>
                            <td>{user.name}</td>
                            <td>{user.email}</td>
                            <td>{user.balance}</td>
                        </tr>
                    )
                }
            })}

        </table>
    );

}

export default UserData;